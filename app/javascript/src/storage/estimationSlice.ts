import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";
import { AxiosError } from "axios";
import { createNewEstimation } from "./apiService";

// Define a type for the slice stated

export interface Estimation {
  price: number
}

export interface EstimationData {
  first_name: string,
  home_changes: number,
  first_time: number
}

interface EstimationState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  estimation_props: EstimationData | undefined,
  price: number
}

interface ValidationErrors {
  errorMessage: string,
  field_errors: Record<string, string>
}

// Define the initial state using that type
const initialState = {
  status: 'succeeded',
  error: undefined,
  estimation_props: undefined,
  price: -1.0
} as EstimationState

const estimationSlice = createSlice({
  name: 'estimations',
  initialState: initialState,
  reducers: {

  },
  extraReducers(builder) {
    builder
      .addCase(calculateEstimation.pending, (state, action) => {
        state.status = 'loading'
      })
      .addCase(calculateEstimation.fulfilled, (state, action) => {
        state.status = 'succeeded'

        let [res, req] = action.payload;
        state.price = res.price;
        state.estimation_props = req;
      })
      .addCase(calculateEstimation.rejected, (state, action) => {
        state.status = 'failed'
        if (action.payload) {
          state.error = action.payload.errorMessage
        } else {
          state.error = action.error.message
        }
      })
  }
})

export const calculateEstimation = createAsyncThunk<[Estimation, EstimationData], EstimationData, { rejectValue: Record<string, string> }>(
  'estimations/calculateEstimation',
  async (data, { rejectWithValue }) => {
    try {
      const response = await createNewEstimation(data);
      return [response, data];
    } catch (err) {
      let error = err as AxiosError<Record<string, string>>;
      if (!error.response) {
        throw err;
      }
      return rejectWithValue(error.response.data)
    }
  }
)


export default estimationSlice.reducer;