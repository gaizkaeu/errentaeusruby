/**
 * Used to preserve the state of the current estimation saved on the
 * session (server side).
 *
 * Used to create the estimation (and save it server-side session)
 */
import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { AxiosError } from "axios";
import { createNewEstimation, myEstimation } from "./apiService";
import { EstimationState, Estimation, EstimationData } from "./types";

// Define the initial state using that type
const initialState = {
  status: "succeeded",
  error: undefined,
  estimation_props: undefined,
  estimation: undefined,
} as EstimationState;

const estimationSlice = createSlice({
  name: "estimations",
  initialState: initialState,
  reducers: {
    resetEstimation(state) {
      state.estimation = undefined;
      state.estimation_props = undefined;
    },
  },
  extraReducers(builder) {
    builder
      .addCase(calculateEstimation.pending, (state, action) => {
        state.status = "loading";
      })
      .addCase(calculateEstimation.fulfilled, (state, action) => {
        state.status = "succeeded";

        const [res, req] = action.payload;
        state.estimation = res;
        state.estimation_props = req;
      })
      .addCase(calculateEstimation.rejected, (state, action) => {
        state.status = "failed";
        if (action.payload) {
          state.error = action.payload.errorMessage;
        } else {
          state.error = action.error.message;
        }
      })
      .addCase(rescueMyEstimation.pending, (state, action) => {
        state.status = "loading";
      })
      .addCase(rescueMyEstimation.fulfilled, (state, action) => {
        state.status = "succeeded";
        if (action.payload) {
          state.estimation = action.payload;
        }
      })
      .addCase(rescueMyEstimation.rejected, (state, action) => {
        state.status = "failed";
        state.error = action.error.message;
      });
  },
});

export const calculateEstimation = createAsyncThunk<
  [Estimation, EstimationData],
  EstimationData,
  { rejectValue: Record<string, string> }
>("estimations/calculateEstimation", async (data, { rejectWithValue }) => {
  try {
    const response = await createNewEstimation(data);
    return [response, data];
  } catch (err) {
    const error = err as AxiosError<Record<string, string>>;
    if (!error.response) {
      throw err;
    }
    return rejectWithValue(error.response.data);
  }
});

export const rescueMyEstimation = createAsyncThunk<Estimation>(
  "estimations/rescueMyEstimation",
  async (data) => {
    const response = await myEstimation();
    return response;
  }
);

export default estimationSlice.reducer;
export const { resetEstimation } = estimationSlice.actions;
