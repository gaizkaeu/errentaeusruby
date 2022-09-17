import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";

export interface Values {
  first_name: string
  firstTime: string
  homeChanges: QuestionWithNumber
  rentalsMortgages: QuestionWithNumber
  realStateTrade: QuestionWithNumber
  withCouple: string,
/*   incomeRent: QuestionWithNumber,
  sharesTrade: QuestionWithNumber, */
  professionalCompanyActivity: string
}

export interface QuestionWithNumber {
  consta: string
  numero: number
}

interface IState {
  formValues: Values,
  step: number
}
  
// Define the initial state using that type
const initialState: IState = {
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