import { Text, useModal } from "@nextui-org/react"
import { setHours, setMinutes } from "date-fns";
import { FormikHelpers } from "formik";
import { useGetEstimationByIdQuery, useUpdateAppointmentByIdMutation } from "../../../storage/api";
import toast from "react-hot-toast";
import AppointmentForm from "../AppointmentForm";
import { useLocation, useNavigate, useParams } from "react-router-dom";
import { Modal } from "@nextui-org/react";
import { useState } from "react";

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
    const loc = useLocation();
    const [open, setOpen] = useState(true)

    const [updateAppointment, result] = useUpdateAppointmentByIdMutation();

    const onSubmit = (values: Values,
        formikHelpers: FormikHelpers<any>,) => {
        const statusToast = toast.loading("Procesando...")
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), +min), +hour)
        console.log(values.method)

        updateAppointment({ id: appointment_id, time: date_new.toString(), method: values.method, phone: values.phone }).unwrap().then((result) => {
            toast.success("¡Listo!", { id: statusToast });
            onClose()
        }).catch((err) => {
            toast.error("Error", { id: statusToast });
            formikHelpers.setErrors(err.data);
        })
    }

    const onClose = () => {
        setOpen(false)
        setTimeout(() => {
            nav(loc.state.background.pathname) 
        }, 200)
    }

    return (
        <Modal
            closeButton
            aria-labelledby="modal-title"
            open={open}
            onClose={onClose}
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


