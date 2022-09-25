import { Text, Button, Input, Radio, Spacer } from "@nextui-org/react"
import { add, setHours, setMinutes } from "date-fns";
import { FieldMetaProps, Form, Formik, FormikHelpers, useField } from "formik";
import React from "react"
import { useAppDispatch } from "../../storage/hooks";
import { setAppointmentToIncomeTax } from "../../storage/taxIncomeSlice";
import DatePickerField from "../FormFields/DatePickerField";
import InputField from "../FormFields/InputField";
import { at } from 'lodash';
import * as Yup from 'yup'

const AppointmentType = (props: { contactMethodFieldName: string, phone_field: string }) => {
    const [methodField, methodMeta, methodHelpers] = useField(props.contactMethodFieldName);

    function _renderHelperText() {
        const [touched, error] = at(methodMeta, 'touched', 'error');
        if (touched && error) {
            return error;
        }
    }

    return (
        <Radio.Group name={props.contactMethodFieldName} label="¿Como quedamos?" onChange={(v) => {methodHelpers.setValue(+v)}}>
            <Radio name={props.contactMethodFieldName} value="0" description="Tu asesor te llamará.">
                Cita telefónica
            </Radio>
            {methodField.value === 0 && <InputField name={props.phone_field} bordered label="Número de teléfono"/>}
            <Radio name={props.contactMethodFieldName} value="1" description="Tendrás que venir a nuestra oficina.">
                Cita presencial
            </Radio>
            <Text color="error">{_renderHelperText()}</Text>
        </Radio.Group>
    );
}

const AppointmentForm = (props: { tax_id: number }) => {

    const dispatch = useAppDispatch();

    const onSubmit = (values: any,
        formikHelpers: FormikHelpers<any>,) => {
        let [hour, min] = values.hour.split(":")
        let date_new = setHours(setMinutes(new Date(values.day), min), hour)
        dispatch(setAppointmentToIncomeTax({ id: props.tax_id, time: date_new }));
    }

    return (
        <Formik initialValues={{ day: '', hour: '12:30', method: '', phone: ''}} validationSchema={Yup.object({
            day: Yup.date().required(),
            hour: Yup.string().min(4, "Hora inválida").required(),
            method: Yup.number().required(),
            phone: Yup.number().when('method', {is: 0, then: Yup.number().min(9).required()})
          })
        } onSubmit={onSubmit}>
            <Form>
                <div className="flex flex-wrap place-content-center gap-4">
                    <DatePickerField name="day" />
                    <div>
                        <InputField name="hour" type="time" label="¿Sobre que hora?" rounded bordered fullWidth></InputField>
                        <Spacer />
                        <AppointmentType contactMethodFieldName="method" phone_field="phone"/>
                    </div>
                </div>
                <Button
                    rounded
                    size="lg"
                    className="px-6 py-4 mt-8"
                    color="primary"
                    type="submit"
                >
                    Concertar cita
                </Button>
            </Form>
        </Formik>
    )
}


export default AppointmentForm;


