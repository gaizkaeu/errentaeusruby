export interface TaxIncome {
  id: string;
  price: number;
  state: TaxIncomeStatus;
  estimation: string;
  lawyer: string;
  appointment: string;
  created_at: string;
  updated_at: string;
}

export interface Document {
  id: string;
  state: "created" | "uploaded" | "ready";
  name: string;
  description: string;
  tax_income_id: string;
  user_id: string;
  lawyer_id: string;
  created_at: string;
  updated_at: string;
  attachments: DocumentAttachment[];
  export_status: "export_successful" | "export_queue" | "not_exported";
  export: DocumentAttachment;
  document_number: number;
}

export interface DocumentHistory {
  id: string;
  document_id: string;
  user_id: string;
  action: "remove_image" | "add_image" | "completed" | "exported";
  description: string;
  created_at: string;
}

export interface DocumentAttachment {
  filename: string;
  url: string;
  id: string;
}

export interface PaymentDetails {
  status:
    | "succeeded"
    | "canceled"
    | "processing"
    | "requires_action"
    | "requires_confirmation";
  amount: number;
  receipt_url: string;
  card: {
    brand: "visa" | "mastercard";
    last4: string;
    wallet: string | undefined;
    refunded: boolean;
  };
}

export interface Appointment {
  id: string;
  lawyer_id: string;
  tax_income_id: string;
  phone: string;
  time: string;
  method: "office" | "phone";
}

export type TaxIncomeStatus =
  | "pending_assignation"
  | "waiting_for_meeting_creation"
  | "waiting_payment"
  | "waiting_for_meeting"
  | "rejected"
  | "pending_documentation"
  | "in_progress"
  | "finished";

export interface TaxIncomeData {
  observations: string;
  estimation: {
    token: string;
  };
}

export type TaxIncomesResponse = TaxIncome[];

export interface AuthState {
  status: "succeeded" | "loading" | "failed";
  error: string | undefined;
  logged_in: boolean;
  fetched: boolean;
  user: IUser | undefined;
}

export interface IUser {
  id: string;
  email: string;
  first_name: string;
  last_name: string;
  confirmed: boolean;
  account_type: "user" | "lawyer";
}

export interface ValidationErrors {
  error: string;
  errors: Record<string, string>;
}

export interface UserRegistrationData {
  name: string;
  surname: string;
  email: string;
  password: string;
  password_confirmation: string;
}

export interface SessionCreationData {
  email: string;
  password: string;
}

export interface Estimation extends EstimationData {
  price: number;
  id: number;
  first_name: string;
  token: {
    data: string;
    exp: string;
  };
}

export interface EstimationData {
  first_name: string;
  home_changes: number;
  first_time: number;
}

export interface EstimationState {
  status: "succeeded" | "loading" | "failed";
  error: string | undefined;
  estimation_props: EstimationData | undefined;
  estimation: Estimation | undefined;
}

export interface CalculatorValues {
  first_name: string;
  firstTime: string;
  homeChanges: QuestionWithNumber;
  rentalsMortgages: QuestionWithNumber;
  realStateTrade: QuestionWithNumber;
  withCouple: string;
  /*   incomeRent: QuestionWithNumber,
    sharesTrade: QuestionWithNumber, */
  professionalCompanyActivity: string;
}

export interface QuestionWithNumber {
  consta: string;
  numero: number;
}

export interface CalculatorState {
  formValues: CalculatorValues;
  step: number;
}
