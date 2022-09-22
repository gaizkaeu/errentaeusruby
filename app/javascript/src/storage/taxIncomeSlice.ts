import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";
import { AxiosError } from "axios";
import { createNewEstimation, createNewTaxIncome, listIncomeTaxes, myEstimation } from "./apiService";

// Define a type for the slice stated

export interface TaxIncome {
  price: number,
  id: number,
  state: number,
  created_at: Date
}

export interface TaxIncomeData {
  load_price_from_estimation: boolean,
  observations: string,
}

interface TaxIncomeState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
}

interface ValidationErrors {
  errorMessage: string,
  field_errors: Record<string, string>
}

const taxAdapter = createEntityAdapter<TaxIncome>({
  selectId: (tax) => tax.id,
})


/* // Define the initial state using that type
const initialState = {
  status: 'succeeded',
  error: undefined,
  taxIncomes: []
} as TaxIncomeState */

const taxIncomeSlice = createSlice({
  name: 'taxincomes',
  initialState: taxAdapter.getInitialState({
    status: 'succeeded',
    error: undefined
  } as TaxIncomeState),
  reducers: {

  },
  extraReducers(builder) {
    builder
      .addCase(createTaxIncome.pending, (state, action) => {
        state.status = 'loading'
      })
      .addCase(createTaxIncome.fulfilled, (state, action) => {
        state.status = 'succeeded';
        taxAdapter.addOne(state, action.payload);
      })
      .addCase(createTaxIncome.rejected, (state, action) => {
        state.status = 'failed'
        if (action.payload) {
          state.error = action.payload.errorMessage
        } else {
          state.error = action.error.message
        }
      })
      .addCase(loadTaxIncomes.pending, (state, action) => {
        state.status = 'loading'
      })
      .addCase(loadTaxIncomes.fulfilled, (state, action) => {
        state.status = 'succeeded';
        taxAdapter.addMany(state, action.payload);
      })
      .addCase(loadTaxIncomes.rejected, (state, action) => {
        state.status = 'failed'
        if (action.payload) {
          state.error = action.error.message
        }
      });
    }
})

export const createTaxIncome = createAsyncThunk<TaxIncome, TaxIncomeData, { rejectValue: ValidationErrors }>(
  'taxincomes/createTaxIncome',
  async (data, { rejectWithValue }) => {
    try {
      const response = await createNewTaxIncome(data);
      return response;
    } catch (err) {
      let error = err as AxiosError<ValidationErrors>;
      if (!error.response) {
        throw err;
      }
      return rejectWithValue(error.response.data)
    }
  }
);
export const loadTaxIncomes = createAsyncThunk<TaxIncome[]>(
  'taxincomes/listTaxIncomes',
  async (a, { rejectWithValue }) => {
    try {
      const response = await listIncomeTaxes();
      return response;
    } catch (err) {
      let error = err as AxiosError<string>;
      if (!error.response) {
        throw err;
      }
      return rejectWithValue(error.response.data)
    }
  }
);


export default taxIncomeSlice.reducer;
export const taxSelector = taxAdapter.getSelectors();