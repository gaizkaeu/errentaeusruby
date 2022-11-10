import { Form, Formik } from "formik"
import { useAddAttachmentToDocumentMutation } from "../../storage/api"
import { Document } from "../../storage/types"
import FileUploader from "../FormFields/FileUploader"

export const AttachmentForm = (props: { document: Document }) => {
    const [addAttachment, resut] = useAddAttachmentToDocumentMutation()

        const onSubmit = (values: {files: FormData}) => {
            console.log(values.files.entries())
            addAttachment({document_id: props.document.id, files: values.files})
        }

        return (
            <Formik onSubmit={onSubmit} initialValues={{files: new FormData()}}>
                <Form>
                <FileUploader name="files"/>
                </Form>
            </Formik>
        )

}