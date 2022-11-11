import { Modal, Text, useModal } from "@nextui-org/react";
import { useNavigate, useParams } from "react-router-dom";
import EstimationEditForm from "../EstimationForm";

const EstimationEditModal = () => {
  const nav = useNavigate();
  const { bindings } = useModal(true);
  const { estimation_id } = useParams();

  bindings.onClose = () => {
    nav(-1);
  };

  return (
    <div>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        animated={false}
        preventClose
        {...bindings}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            <Text b size={18}>
              Editar estimación
            </Text>
          </Text>
        </Modal.Header>
        <Modal.Body>
          <EstimationEditForm id={estimation_id!} />
        </Modal.Body>
        <Modal.Footer>
          <Text weight="light">Todos los datos están encriptados.</Text>
        </Modal.Footer>
      </Modal>
    </div>
  );
};
export default EstimationEditModal;
