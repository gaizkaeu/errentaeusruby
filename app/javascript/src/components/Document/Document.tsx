import { Button, Card, Text } from "@nextui-org/react";
import { useDeleteDocumentAttachmentByIdMutation } from "../../storage/api";
import { Document } from "../../storage/types";
import { AssignedLawyerSimple } from "../Lawyer/AssignedLawyer";

export const DocumentComponent = (props: {document: Document}) => {
    const {document} = props;
    const [deleteAttachment, result] = useDeleteDocumentAttachmentByIdMutation()

    return (
        <div>
            <Card variant="flat">
                <Card.Header>{document.name} | {document.state}</Card.Header>
                <Card.Divider/>
                <Card.Body>
                    {document.attachments.map((a) => (
                        <div>
                        <a href={a.url}> {a.filename}</a>
                        <Button onPress={() => deleteAttachment({document_id: document.id, attachment_id: a.id})}>Eliminar</Button>
                        </div>
                    ))}
                </Card.Body>
                <Card.Footer>
                    <div className="flex flex-wrap">
                        <Text size="small">Solicitado por</Text> 
                        <AssignedLawyerSimple size="xs" lawyerId={document.requested_by_id}/>
                    </div>
                </Card.Footer>
            </Card>
        </div>
    )
}