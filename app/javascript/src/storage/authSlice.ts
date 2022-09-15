import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";
import { post, destroy, get } from '@rails/request.js'

// Define a type for the slice stated

interface IState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  logged_in: boolean,
  user: {} 
}
  
// Define the initial state using that type
const initialState: IState = {
    status: 'succeeded',
    error: '',
    logged_in: false,
    user: {}
}

const authSlice = createSlice({
    name: 'authentication',
    initialState: initialState,
    reducers: {

    },
    extraReducers(builder) {
        builder
          .addCase(signIn.pending, (state, action) => {
            state.status = 'loading'
          })
          .addCase(signIn.fulfilled, (state, action) => {
            state.status = 'succeeded'

            let [res, status] = action.payload;
            state.logged_in = status;
            state.user = res;
          })
          .addCase(signIn.rejected, (state, action) => {
            state.status = 'failed'
            state.error = action.error.message!
          })
          .addCase(signUp.pending, (state, action) => {
            state.status = 'loading'
          })
          .addCase(signUp.fulfilled, (state, action) => {
            state.status = 'succeeded'

            let [res, status] = action.payload;
            state.logged_in = status;
            state.user = res;
          })
          .addCase(signUp.rejected, (state, action) => {
            state.status = 'failed'
            state.error = action.error.message!
          })
          .addCase(logOut.pending, (state, action) => {
            state.status = 'loading'
          })
          .addCase(logOut.fulfilled, (state, action) => {
            state.status = 'succeeded'

            let [status] = action.payload;
            state.logged_in = !status;
          })
          .addCase(logOut.rejected, (state, action) => {
            state.status = 'failed'
            state.error = action.error.message!
          })
          .addCase(loggedIn.pending, (state, action) => {
            state.status = 'loading'
          })
          .addCase(loggedIn.fulfilled, (state, action) => {
            state.status = 'succeeded'

            let [res] = action.payload;
            state.logged_in = res.logged_in
            state.user = res.user
          })
          .addCase(loggedIn.rejected, (state, action) => {
            state.status = 'failed'
            state.error = action.error.message!
          })
      }
})

export const signIn = createAsyncThunk(
    'auth/logIn',
    async (obj: {email: string, password: string, remember_me: boolean}) => {
        const response = await post('/api/v1/users/sign_in', {body: {api_v1_user: obj}})
        
        return [(await response.json), response.ok] as const
    }
)

export const loggedIn = createAsyncThunk(
  'auth/loggedIn',
  async () => {
      const response = await get('/api/v1/logged_in')
      
      return [(await response.json), response.ok] as const
  }
)

export const logOut = createAsyncThunk(
    'auth/logOut',
    async () => {
        const response = await destroy('/api/v1/users/sign_out')
        
        return [response.ok] as const
    }
)


export const signUp = createAsyncThunk(
    'auth/signUp',
    async (obj: {email: string, password: string, password_confirmation: string}) => {
        const response = await post('/api/v1/users', {body: {api_v1_user: obj}})
        
        return [(await response.json), response.ok] as const
    }
)


export default authSlice.reducer;