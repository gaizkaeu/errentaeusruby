import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";
import { post } from '@rails/request.js'

// Define a type for the slice stated

export interface IEstimation {
    price: number
}

export interface IEstimationProps {
  first_name: string,
  home_changes: number,
  first_time: number
}

interface IState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  estimation_props: IEstimationProps | undefined,
  price: number
}
  
// Define the initial state using that type
const initialState: IState = {
    status: 'succeeded',
    error: '',
    estimation_props: undefined,
    price: -1.0
}

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
            state.error = action.error.message!
          })
      }
})

export const calculateEstimation = createAsyncThunk(
    'estimations/calculateEstimation',
    async (obj: IEstimationProps) => {
        const response = await post('http://localhost:3000/api/v1/estimations/estimate', {body: obj})
        
        return [(await response.json) as IEstimation, obj] as const
    }
)


export default estimationSlice.reducer;