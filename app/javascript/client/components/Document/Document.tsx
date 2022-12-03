import {
  Badge,
  Button,
  Card,
  Loading,
  Table,
  Text,
  User,
} from "@nextui-org/react";
import { formatRelative } from "date-fns";
import es from "date-fns/locale/es";
import { Form, Formik } from "formik";
import { useTranslation } from "react-i18next";
import { Link, useLocation } from "react-router-dom";
import { useAuth } from "../../hooks/authHook";
import {
  useCreateDocumentMutation,
  useDeleteDocumentAttachmentByIdMutation,
  useExportDocumentByIdMutation,
  useGetDocumentHistoryByIdQuery,
  useGetDocumentsOfTaxIncomeQuery,
} from "../../storage/api";
import { useAppSelector } from "../../storage/hooks";
import { Document } from "../../storage/types";
import InputField from "../FormFields/InputField";
import { AssignedLawyerSimple } from "../Lawyer/AssignedLawyer";
import { AttachmentForm } from "./AttachmentForm";

export const Documents = (props: { taxIncomeId: string }) => {
  const { currentUser } = useAuth();
  const { currentData, isLoading, isError } = useGetDocumentsOfTaxIncomeQuery(
    props.taxIncomeId,
    {
      pollingInterval: 3000,
    }
  );

  return (
    <div className="grid grid-cols-1 gap-4">
      {currentUser && currentUser.account_type == "lawyer" && (
        <DocumentCreationComponent taxIncomeId={props.taxIncomeId} />
      )}
      {currentData &&
        !isLoading &&
        !isError &&
        currentData.map((doc, index) => (
          <DocumentComponent document={doc} key={index} />
        ))}
    </div>
  );
};

export const DocumentHistory = (props: { documentId: string }) => {
  const { t } = useTranslation();
  const RenderUser = (props: { userId: string }) => {
    const currentUser = useAppSelector((state) => state.authentication.user);

    return currentUser ? (
      currentUser.id === props.userId ? (
        <User
          bordered
          color="secondary"
          size="md"
          text={currentUser.first_name}
          name={currentUser.first_name}
        />
      ) : (
        <AssignedLawyerSimple size="md" lawyerId={props.userId} />
      )
    ) : (
      <Loading />
    );
  };

  const { currentData, isLoading, isError } = useGetDocumentHistoryByIdQuery(
    props.documentId
  );

  return currentData && !isLoading && !isError ? (
    <Table
      aria-label="history table"
      css={{
        height: "auto",
        minWidth: "100%",
      }}
    >
      <Table.Header>
        <Table.Column>{t("documents.history.action")}</Table.Column>
        <Table.Column>{t("documents.history.user")}</Table.Column>
        <Table.Column>{t("documents.history.date")}</Table.Column>
        <Table.Column>{t("documents.history.description")}</Table.Column>
      </Table.Header>
      <Table.Body>
        {currentData!.map((action, ind) => (
          <Table.Row key={ind}>
            <Table.Cell>{action.action}</Table.Cell>
            <Table.Cell>
              <RenderUser userId={action.user_id} />
            </Table.Cell>
            <Table.Cell>{action.created_at}</Table.Cell>
            <Table.Cell>{action.description}</Table.Cell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table>
  ) : (
    <Loading />
  );
};

const DocumentActions = (props: { document: Document }) => {
  const { document } = props;
  const { t } = useTranslation();
  const [exportDocument] = useExportDocumentByIdMutation();

  return (
    <div className="flex w-full">
      {document.export_status == "export_successful" && (
        <Link to={document.export.url}>
          <Button auto color="primary" rounded>
            {t("documents.actions.viewDocument")}
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
            {t("documents.actions.export")}
          </Button>
        )}
    </div>
  );
};

export const DocumentCreationComponent = (props: { taxIncomeId: string }) => {
  const [createDocument] = useCreateDocumentMutation();
  const onSubmit = (values: Partial<Document>) => {
    createDocument(values);
  };

  return (
    <Card variant="flat" role="article">
      <Card.Header>Nuevo documento</Card.Header>
      <Card.Divider />
      <Card.Body>
        <div>
          <Formik
            initialValues={{
              tax_income_id: props.taxIncomeId,
            }}
            onSubmit={onSubmit}
          >
            <Form>
              <InputField name="name"></InputField>
              <InputField name="document_number"></InputField>
              <button type="submit">enviar</button>
            </Form>
          </Formik>
        </div>
      </Card.Body>
    </Card>
  );
};

export const DocumentComponent = (props: { document: Document }) => {
  const { document } = props;
  const { t } = useTranslation();
  const location = useLocation();
  const [deleteAttachment] = useDeleteDocumentAttachmentByIdMutation();

  return (
    <Card variant="flat" role="article">
      <Card.Header>
        <div className="flex w-full">
          <div className="grow">
            <Text b>{document.name}</Text>
          </div>
          <div className="flex-none">
            {document.state == "ready" ? (
              <Badge color="success" variant="flat">
                {t("documents.status.completed")}
              </Badge>
            ) : (
              <Text>
                <Badge color="primary" variant="flat">
                  {t("documents.status.pending")} {document.attachments.length}/
                  {document.document_number}
                </Badge>
              </Text>
            )}
          </div>
        </div>
      </Card.Header>
      <Card.Divider />
      <Card.Body>
        <div className="flex flex-wrap gap-5">
          {document.attachments.map((a, ind) => (
            <div key={ind}>
              <a href={a.url}> {a.filename}</a>
              <Button
                onPress={() =>
                  deleteAttachment({
                    document_id: document.id,
                    attachment_id: a.id,
                  })
                }
              >
                {t("documents.actions.delete")}
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
        <div className="flex gap-2 w-full flex-wrap">
          <div className="flex-1">
            <Text size="small">
              <Link
                to={`/documents/${document.id}/history`}
                state={{ background: location }}
              >
                {t("documents.info.history")}
              </Link>{" "}
              {t("documents.info.lastUpdate")}{" "}
              {formatRelative(new Date(document.updated_at), new Date(), {
                locale: es,
              })}
            </Text>
          </div>
          <div className="flex items-center">
            <Text size="small">{t("documents.info.askedBy")}</Text>
            <AssignedLawyerSimple size="xs" lawyerId={document.lawyer_id} />
          </div>
        </div>
      </Card.Footer>
    </Card>
  );
};
