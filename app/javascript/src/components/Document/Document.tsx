import {
  Badge,
  Button,
  Card,
  Loading,
  Table,
  Text,
} from "@nextui-org/react"
import { formatRelative } from "date-fns"
import es from "date-fns/locale/es"
import { Link, useLocation } from "react-router-dom"
import {
  useDeleteDocumentAttachmentByIdMutation,
  useExportDocumentByIdMutation,
  useGetDocumentHistoryByIdQuery,
} from "../../storage/api"
import { Document } from "../../storage/types"
import { AssignedLawyerSimple } from "../Lawyer/AssignedLawyer"
import { AttachmentForm } from "./AttachmentForm"

export const DocumentHistory = (props: { documentId: string }) => {
  const { currentData, isLoading, isError } = useGetDocumentHistoryByIdQuery(props.documentId)

  return currentData && !isLoading ? (
    <Table
      aria-label="Example table with static content"
      css={{
        height: "auto",
        minWidth: "100%",
      }}
    >
      <Table.Header>
        <Table.Column>ACCION</Table.Column>
        <Table.Column>USUARIO</Table.Column>
        <Table.Column>FECHA</Table.Column>
        <Table.Column>DESCRIPCIÓN</Table.Column>
      </Table.Header>
      <Table.Body>
        {currentData!.map((action, ind) => (
          <Table.Row key={ind}>
            <Table.Cell>{action.action}</Table.Cell>
            <Table.Cell>{action.user_id}</Table.Cell>
            <Table.Cell>{action.created_at}</Table.Cell>
            <Table.Cell>{action.description}</Table.Cell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table>
  ) : <Loading/>
}

const DocumentActions = (props: { document: Document }) => {
  const { document } = props
  const [exportDocument, resula] = useExportDocumentByIdMutation()

  return (
    <div className="flex w-full">
      {document.export_status == "export_successful" && (
        <Link to={document.export.url}>
          <Button auto color="primary" rounded>
            Documento exportado
          </Button>
        </Link>
      )}
      {document.export_status == "export_queue" && (
        <Button disabled auto bordered color="warning" css={{ px: "$13" }}>
          <Loading type="points-opacity" color="currentColor" size="sm" />
        </Button>
      )}
      {document.export_status == "not_exported" &&
        document.attachments.length != 0 && (
          <Button
            auto
            color="primary"
            rounded
            onPress={() => exportDocument(document.id)}
          >
            Exportar como pdf
          </Button>
        )}
    </div>
  )
}

export const DocumentComponent = (props: { document: Document }) => {
  const { document } = props
  const location = useLocation()
  const [deleteAttachment, result] = useDeleteDocumentAttachmentByIdMutation()

  return (
    <div>
      <Card variant="flat">
        <Card.Header>
          <div className="flex w-full">
            <div className="grow">
              <Text b>{document.name}</Text>
            </div>
            <div className="flex-none">
              {document.state == "ready" ? (
                <Badge color="success" variant="flat">
                  Completado
                </Badge>
              ) : (
                <Text>
                <Badge color="primary" variant="flat">
                  Pendiente {document.attachments.length}/{document.document_number}
                </Badge>
                </Text>
              )}
            </div>
          </div>
        </Card.Header>
        <Card.Divider />
        <Card.Body>
          <div className="flex flex-wrap gap-5">
            {document.attachments.map((a) => (
              <div>
                <a href={a.url}> {a.filename}</a>
                <Button
                  onPress={() =>
                    deleteAttachment({
                      document_id: document.id,
                      attachment_id: a.id,
                    })
                  }
                >
                  Eliminar
                </Button>
              </div>
            ))}
          </div>
          {document.attachments.length < document.document_number && (
            <div className="mt-3">
              <AttachmentForm document={document} />
            </div>
          )}
          <br />
          <DocumentActions document={document} />
        </Card.Body>
        <Card.Divider />
        <Card.Footer>
          <div className="flex flex-wrap gap-2">
            <Text size="small">
              <Link to={`/documents/${document.id}/history`} state={{ background: location }}>Historial</Link>
            </Text>
            <Text size="small">
              Actualizado{" "}
              {formatRelative(new Date(document.updated_at), new Date(), {
                locale: es,
              })}
            </Text>
            <Text size="small">Solicitado por</Text>
            <AssignedLawyerSimple size="xs" lawyerId={document.lawyer_id} />
          </div>
        </Card.Footer>
      </Card>
    </div>
  )
}
