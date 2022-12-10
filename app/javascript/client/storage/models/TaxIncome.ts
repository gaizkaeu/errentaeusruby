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

export interface TaxIncomeData extends Partial<TaxIncomeBase> {
  client_id: string;
  observations: string;
  estimation: {
    token: string;
  };
}

export type TaxIncomesResponse = TaxIncome[];

export interface TaxIncomeBase {
  price: number;
  state: TaxIncomeStatus;
  client: string;
  lawyer: string;
  year?: number;
}

export interface TaxIncome extends TaxIncomeBase {
  id: string;
  appointment: string;
  created_at: string;
  updated_at: string;
  estimation: string;
}
