import { setHours, setMinutes } from "date-fns";
import { FormikHelpers } from "formik";
import { useCreateAppointmentToTaxIncomeMutation } from "../../storage/api";
import toast from "react-hot-toast";
import AppointmentForm from "./AppointmentForm";

interface Values {
    day: string,
    hour: string,
    method: "office" | "phone"
    phone: string
}


const NewAppointment = (props: { taxIncomeId: string }) => {

    const [addNewAppointment, result] = useCreateAppointmentToTaxIncomeMutation();

    const onSubmit = (values: Values,
        formikHelpers: FormikHelpers<any>,) => {
        const statusToast = toast.loading("Procesando...")
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), +min), +hour)

        addNewAppointment({tax_income_id: props.taxIncomeId, time: date_new.toString(), method: values.method, phone: values.phone}).unwrap().then((result) => {
            toast.success("¡Listo!", {id: statusToast});
        }).catch((err) => {
            toast.error("Error", {id: statusToast});
            formikHelpers.setErrors(err.data);
        })
    }

    return (
        <AppointmentForm onSubmit={onSubmit}/>
    )
}


export default NewAppointment;


