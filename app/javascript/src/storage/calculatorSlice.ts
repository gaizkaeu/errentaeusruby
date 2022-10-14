import { createSlice } from "@reduxjs/toolkit";
import { CalculatorState } from "./types";

const initialState: CalculatorState = {
  formValues: {
    first_name: '',
    homeChanges: {
      consta: '',
      numero: 1,
    },
    rentalsMortgages: {
      consta: '',
      numero: 1,
    },
    realStateTrade: {
      consta: '',
      numero: 1,
    },
    firstTime: '',
    withCouple: '',
    professionalCompanyActivity: '',
  },
  step: 0
}

const calculatorSlice = createSlice({
    name: 'calculator',
    initialState: initialState,
    reducers: {
      valuesChanged(state, payload) {
        state.formValues = payload.payload;
      },
      nextStep(state) {
        state.step++;
      },
      prevStep(state) {
        state.step--;
      },
      firstStep(state) {
        state.step = 0;
      }
    }
})

export default calculatorSlice.reducer;
export const { valuesChanged, nextStep, prevStep, firstStep } = calculatorSlice.actions