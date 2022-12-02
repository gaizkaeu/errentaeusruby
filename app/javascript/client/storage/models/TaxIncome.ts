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

export type TaxIncomeStatus = typeof TaxIncomeStatuses[number];

export interface TaxIncomeData {
  observations: string;
  estimation: {
    token: string;
  };
}

export type TaxIncomesResponse = TaxIncome[];

export interface TaxIncome {
  id: string;
  price: number;
  state: TaxIncomeStatus;
  user: string;
  estimation: string;
  lawyer: string;
  appointment: string;
  created_at: string;
  updated_at: string;
}
