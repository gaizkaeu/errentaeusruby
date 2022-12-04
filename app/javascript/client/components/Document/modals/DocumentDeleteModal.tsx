import { TrashIcon } from "@heroicons/react/24/outline";
import { Modal, Text } from "@nextui-org/react";
import { useState } from "react";
import toast from "react-hot-toast";
import { useTranslation } from "react-i18next";
import { useDeleteDocumentByIdMutation } from "../../../storage/api";
import { Button } from "../../../utils/GlobalStyles";
import { DeletedSuccessfully } from "../../Toasts/TaxIncome";

export const DocumentDeleteModal = (props: { documentId: string }) => {
  const [visible, setVisible] = useState(false);
  const { t } = useTranslation();
  const handler = () => setVisible(true);

  const closeHandler = () => {
    setVisible(false);
  };

  const [deleteDocument] = useDeleteDocumentByIdMutation();

  const confirmDelete = () => {
    deleteDocument(props.documentId)
      .unwrap()
      .then(() => {
        toast.custom((t) => <DeletedSuccessfully t={t} />);
      });
    setVisible(false);
  };

  return (
    <div>
      <Button
        auto
        color="error"
        onClick={handler}
        icon={<TrashIcon height="15px" />}
        aria-label="delete document"
      />
      <Modal
        closeButton
        blur
        aria-labelledby="modal-title"
        open={visible}
        onClose={closeHandler}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            {t("document.actions.delete.modalTitle")}
          </Text>
        </Modal.Header>
        <Modal.Body>
          <Text>{t("taxincome.actions.delete.disclaimer")}</Text>
        </Modal.Body>
        <Modal.Footer>
          <Button auto flat color="error" onClick={confirmDelete}>
            {t("taxincome.actions.delete.confirmButton")}
          </Button>
          <Button auto onClick={closeHandler}>
            {t("taxincome.actions.delete.cancel")}
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};
