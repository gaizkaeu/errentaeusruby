import { Text } from "@nextui-org/react";
import AppointmentForm from "../AppointmentForm";
import { useParams } from "react-router-dom";
import { Modal } from "@nextui-org/react";
import { useAppointment } from "../../../hooks/useAppointment";

const EditAppointment = () => {
  const { appointment_id } = useParams();
  const { modal, appointment } = useAppointment(appointment_id!);

  return (
    <Modal
      closeButton
      aria-labelledby="modal-title"
      open={modal.open}
      width="800px"
      onClose={modal.onClose}
    >
      <Modal.Header>
        <Text id="modal-title" size={18} b>
          Editar mi cita
        </Text>
      </Modal.Header>
      <Modal.Body>
        <AppointmentForm onSubmit={appointment.updateFormSubmit} />
      </Modal.Body>
    </Modal>
  );
};

export default EditAppointment;
