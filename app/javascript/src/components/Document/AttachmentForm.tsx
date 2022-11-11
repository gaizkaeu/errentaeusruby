import { Loading } from "@nextui-org/react";
import { Form, Formik, FormikHelpers } from "formik";
import { useAddAttachmentToDocumentMutation } from "../../storage/api";
import { Document } from "../../storage/types";
import FileUploader from "../FormFields/FileUploader";

export const AttachmentForm = (props: { document: Document }) => {
  const [addAttachment] = useAddAttachmentToDocumentMutation();

  const onSubmit = (
    values: { files: FormData },
    helpers: FormikHelpers<any>
  ) => {
    helpers.setSubmitting(true);
    addAttachment({ document_id: props.document.id, files: values.files }).then(
      () => helpers.setSubmitting(false)
    );
  };

  return (
    <Formik onSubmit={onSubmit} initialValues={{ files: new FormData() }}>
      {({ isSubmitting }) => (
        <Form>
          <FileUploader name="files" />
          {isSubmitting && <Loading />}
        </Form>
      )}
    </Formik>
  );
};
