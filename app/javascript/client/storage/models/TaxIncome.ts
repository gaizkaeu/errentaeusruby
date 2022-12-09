export const TaxIncomeStatuses = [
  "pending_assignation",
  "waiting_for_meeting_creation",
  "waiting_payment",
  "waiting_for_meeting",
  "rejected",
  "pending_documentation",
  "in_progress",
  "finished",
] as const;

export const TaxIncomeSearchKeys = ["name", "creation_date"] as const;

export type TaxIncomeStatus = typeof TaxIncomeStatuses[number];
export type TaxIncomeSearch = typeof TaxIncomeSearchKeys[number];

export interface TaxIncomeData {
  client_id: string;
  observations: string;
  estimation: {
    token: string;
  };
}

export type TaxIncomesResponse = TaxIncome[];

export interface TaxIncomeBase {
  id: string;
  price: number;
  state: TaxIncomeStatus;
  user: string;
  estimation: string;
  lawyer: string;
  appointment: string;
  year?: number;
}

export interface TaxIncome extends TaxIncomeBase {
  created_at: string;
  updated_at: string;
}
