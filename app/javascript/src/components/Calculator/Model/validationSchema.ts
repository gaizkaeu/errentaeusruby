import * as Yup from 'yup'

const validationSchema = [
    Yup.object().shape({
        first_name: Yup.string()
            .min(2, 'Demasiado corto')
            .max(50, 'Demasiado largo')
            .required('Es necesario rellenar este campo'),
    }),
    Yup.object().shape({
        firstTime: Yup.boolean().required('Selecciona una opción'),
    }),

    Yup.object().shape({
        homeChanges: Yup.object().shape({
            consta: Yup.boolean().required('Selecciona una opción'),
            numero: Yup.number().when('consta', {
                is: true,
                then: Yup.number().min(1, 'Debe de ser mayor a 0').required('Es necesario rellenar este campo'),
            })
        }),
    }),
    Yup.object().shape({
        rentalsMortgages: Yup.object().shape({
            consta: Yup.boolean().required('Selecciona una opción'),
            numero: Yup.number().when('consta', {
                is: true,
                then: Yup.number().min(1, 'Debe de ser mayor a 0').required('Es necesario rellenar este campo'),
            })
        }),
    }),
    Yup.object().shape({
        professionalCompanyActivity: Yup.boolean().required('Selecciona una opción'),
    }),
    Yup.object().shape({
        realStateTrade: Yup.object().shape({
            consta: Yup.boolean().required('Selecciona una opción'),
            numero: Yup.number().when('consta', {
                is: true,
                then: Yup.number().min(1, 'Debe de ser mayor a 0').required('Es necesario rellenar este campo'),
            })
        }),
    }),
    Yup.object().shape({
        withCouple: Yup.boolean().required('Selecciona una opción'),
    }),
]


export default validationSchema;