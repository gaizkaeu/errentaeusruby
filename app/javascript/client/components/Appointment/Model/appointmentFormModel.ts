const fields = {
  formId: "checkoutForm",
  formField: {
    first_name: {
      name: "first_name",
      label: "Nombre",
      requiredErrorMsg: "First name is required",
    },
    homeChangesNum: {
      name: "homeChanges.numero",
      label: "¿Cuántas veces has cambiado de vivienda habitual?",
      requiredErrorMsg: "Last name is required",
    },
    homeChangesQ: {
      name: "homeChanges.consta",
      label: "¿Cuántas?",
      requiredErrorMsg: "Last name is required",
    },
    rentalsMortgagesNum: {
      name: "rentalsMortgages.numero",
      label: "¿Cuántos alquileres y/o hipotecas tienes?",
      requiredErrorMsg: "Last name is required",
    },
    rentalsMortgagesQ: {
      name: "rentalsMortgages.consta",
      label: "¿Cuántas?",
      requiredErrorMsg: "Last name is required",
    },
    firstTime: {
      name: "firstTime",
      label: "¿Es la primera vez?",
      requiredErrorMsg: "Last name is required",
    },
    professionalCompanyActivity: {
      name: "professionalCompanyActivity",
      label: "¿Tienes actividad empresarial o profesional??",
      requiredErrorMsg: "Last name is required",
    },
    realStateTradeNum: {
      name: "realStateTrade.numero",
      label: "¿Cuántos inmuebles has comprado / vendido?",
      requiredErrorMsg: "Last name is required",
    },
    realStateTradeQ: {
      name: "realStateTrade.consta",
      label: "¿Cuántas?",
      requiredErrorMsg: "Last name is required",
    },
    withCouple: {
      name: "withCouple",
      label:
        "¿Quieres hacer la declaración en matrimonio o con tu pareja de hecho?",
      requiredErrorMsg: "Last name is required",
    },
  },
};

interface FieldData {
  name: string;
  label: string;
  requiredErrorMsg: string;
}

export default fields;
export type { FieldData };
