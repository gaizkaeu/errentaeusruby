import React from "react";
import { Text } from "@nextui-org/react";
import InputField from "../../FormFields/InputField";

export default function Start(formField: {formField: {
    first_name: {
        name: String,
        label: String,
        requiredErrorMsg: String
    }
}}) {
    const {
        formField: {
            first_name,
        }
    } = formField;

    return (
        <React.Fragment>
            <Text h3>Bienvenido al apartado de estimación.</Text>
            <Text h4 weight={'normal'}>Aquí podrás obtener un precio estimado para la realización de la declaración de la renta. Una vez obtenida la estimación podrás decidir si sigues adelante o no.</Text>
            <InputField name={first_name.name} label={first_name.label} rounded bordered fullWidth></InputField>
            <br/>
            <br/>
            <Text h5 className="underline">IMPORTANTE</Text>
            <Text h6 weight={'normal'}>La privacidad es importante para nosotros, por lo que no guardamos <b>nada de información</b> sobre tu estimación. Únicamente guardaremos tus datos si decides realizar la declaración con nosotros.</Text>
        </React.Fragment>
    )
}