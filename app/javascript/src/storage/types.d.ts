export interface TaxIncome {
  id: string,
  price: number,
  state: TaxIncomeStatus,
  estimation: string,
  lawyer: string,
  appointment: string,
  created_at: string,
  updated_at: string
}

export interface Appointment {
  id: string,
  lawyer_id: string,
  tax_income_id: string,
  phone: string,
  time: string,
  method: "office" | "phone"
}

export type TaxIncomeStatus = "pending_assignation" | "waiting_for_meeting_creation" | "waiting_for_meeting" | "rejected" | "pending_documentation" | "in_progress" | "finished"

export interface TaxIncomeData {
  load_price_from_estimation: boolean,
  observations: string,
}

export type TaxIncomesResponse = TaxIncome[]


export interface AuthState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  logged_in: boolean,
  fetched: boolean,
  user: IUser | undefined
}

export interface IUser {
  email: string,
  name: string,
  surname: string,
  account_type: "user" | "lawyer"
}

export interface ValidationErrors {
  error: string
  errors: Record<string, string>
}

export interface UserRegistrationData {
  name: string,
  surname: string
  email: string,
  password: string,
  password_confirmation: string
}

export interface SessionCreationData {
  email: string,
  password: string,
}

export interface Estimation extends EstimationData {
  price: number,
  id: number,
  first_name: string
}

export interface EstimationData {
  first_name: string,
  home_changes: number,
  first_time: number
}

export interface EstimationState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  estimation_props: EstimationData | undefined,
  estimation: Estimation | undefined
}


export interface CalculatorValues {
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

export interface CalculatorState {
  formValues: CalculatorValues,
  step: number
}