import { Text } from "@nextui-org/react"
import { setHours, setMinutes } from "date-fns";
import { FormikHelpers } from "formik";
import { useUpdateAppointmentByIdMutation } from "../../storage/api";
import toast from "react-hot-toast";
import AppointmentForm from "./AppointmentForm";
import { useNavigate, useParams } from "react-router-dom";
import { Modal } from "@nextui-org/react";

interface Values {
    day: string,
    hour: string,
    method: "office" | "phone"
    phone: string
    appointment_id?: string
}


const EditAppointment = () => {
    const { appointment_id } = useParams()
    const nav = useNavigate()

    const [updateAppointment, result] = useUpdateAppointmentByIdMutation();

    const onSubmit = (values: Values,
        formikHelpers: FormikHelpers<any>,) => {
        const statusToast = toast.loading("Procesando...")
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), +min), +hour)
        console.log(values.method)

        updateAppointment({ id: appointment_id, time: date_new.toString(), method: values.method, phone: values.phone }).unwrap().then((result) => {
            toast.success("¡Listo!", { id: statusToast });
            onClose();
        }).catch((err) => {
            toast.error("Error", { id: statusToast });
            formikHelpers.setErrors(err.data);
        })
    }

    const onClose = () => {
        nav(-1)
    }

    return (
        <Modal
            closeButton
            aria-labelledby="modal-title"
            onClose={onClose}
            open={true}
        >
            <Modal.Header>
                <Text id="modal-title" size={18}>
                    Editar {appointment_id} cita
                </Text>
            </Modal.Header>
            <Modal.Body>
                <AppointmentForm onSubmit={onSubmit} />
            </Modal.Body>
        </Modal>
    )
}


export default EditAppointment;


