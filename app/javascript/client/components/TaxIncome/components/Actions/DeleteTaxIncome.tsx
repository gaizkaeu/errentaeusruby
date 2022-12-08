import { TrashIcon } from "@heroicons/react/24/outline";
import { Modal, Text } from "@nextui-org/react";
import { useState } from "react";
import toast from "react-hot-toast";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { useDeleteTaxIncomeMutation } from "../../../../storage/api";
import { Button } from "../../../../utils/GlobalStyles";
import { DeletedSuccessfully } from "../../../Toasts/TaxIncome";

export const TaxIncomeDeleteComponent = (props: { taxIncomeId: string }) => {
  const [visible, setVisible] = useState(false);
  const { t } = useTranslation();
  const nav = useNavigate();
  const handler = () => setVisible(true);
  const closeHandler = () => {
    setVisible(false);
  };

  const confirmDelete = () => {
    deleteTaxIncome(props.taxIncomeId)
      .unwrap()
      .then(() => {
        setVisible(false);
        toast.custom((t) => <DeletedSuccessfully t={t} />);
        nav("/mytaxincome", { replace: true });
      });
  };

  const [deleteTaxIncome] = useDeleteTaxIncomeMutation();

  return (
    <div>
      <Button
        auto
        color="error"
        onClick={handler}
        aria-label="delete tax income"
      >
        <span className="md:hidden">
          <TrashIcon height="15px" />
        </span>
        <span className="hidden md:inline">
          {t("taxincome.actions.delete.button")}
        </span>
      </Button>
      <Modal
        closeButton
        blur
        aria-labelledby="modal-title"
        open={visible}
        onClose={closeHandler}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            {t("taxincome.actions.delete.modalTitle")}
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
