import { setHours, setMinutes } from "date-fns"
import { FormikHelpers } from "formik"
import { useState } from "react"
import toast from "react-hot-toast"
import { useTranslation } from "react-i18next"
import { useLocation, useNavigate } from "react-router-dom"
import { useCreateAppointmentToTaxIncomeMutation, useUpdateAppointmentByIdMutation } from "../storage/api"

export const useAppointment = (id: string, tax_income_id?: string) => {

    const [open, setOpen] = useState(true)
    const nav = useNavigate()
    const loc = useLocation();
    const [updateAppointment, updateResult] = useUpdateAppointmentByIdMutation();
    const [addNewAppointment, result] = useCreateAppointmentToTaxIncomeMutation();
    const { t } = useTranslation();

    interface Values {
        day: string,
        hour: string,
        method: "office" | "phone"
        phone: string
        appointment_id?: string
    }

    const initialValues = () => {
        if (id !== "undefined") {

        } else {
            
        }

    }

    const submitAppointmentEdit = (values: Values,
        formikHelpers: FormikHelpers<any>) => {

        const statusToast = toast.loading(t('global.loading'))
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), +min), +hour)
        console.log(values.method)

        updateAppointment({ id: id, time: date_new.toString(), method: values.method, phone: values.phone }).unwrap().then((result) => {
            toast.success(t('global.ok'), { id: statusToast });
            onClose()
        }).catch((err) => {
            toast.error(t('errors.unexpected'), { id: statusToast });
            formikHelpers.setErrors(err.data);
        })
    }

    const submitAppointmentNew = (values: Values,
        formikHelpers: FormikHelpers<any>,) => {
        const statusToast = toast.loading("Procesando...")
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), +min), +hour)

        addNewAppointment({ tax_income_id: tax_income_id, time: date_new.toString(), method: values.method, phone: values.phone }).unwrap().then((result) => {
            toast.success(t('global.ok'), { id: statusToast });
        }).catch((err) => {
            toast.error(t('errors.unexpected'), { id: statusToast });
            formikHelpers.setErrors(err.data);
        })
    }

    const onClose = () => {
        setOpen(false)
        setTimeout(() => {
            nav(loc.state.background.pathname)
        }, 200)
    }

    return {
        modal: {
            open: open,
            onClose: onClose
        },
        appointment: {
            updateFormSubmit: submitAppointmentEdit,
            newFormSubmit: submitAppointmentNew
        }
    }
}