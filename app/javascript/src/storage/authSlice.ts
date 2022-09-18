import { createSlice, createAsyncThunk, createEntityAdapter } from "@reduxjs/toolkit";
import axios, { AxiosError } from "axios";
import { checkLoggedIn, closeSession, createNewSession, createNewUser } from "./apiService";

// Define a type for the slice stated

interface AuthState {
  status: 'succeeded' | 'loading' | 'failed'
  error: string | undefined
  logged_in: boolean,
  user: CurrentUser | undefined
}

export interface CurrentUser {
  email: string
}

interface ValidationErrors {
  error: string
  errors: Record<string, string>
}

export interface UserRegistrationData {
  email: string,
  password: string,
  password_confirmation: string
}

export interface SessionCreationData {
  email: string,
  password: string,
}

// Define the initial state using that type
const initialState = {
  status: 'succeeded',
  error: '',
  logged_in: false,
  user: undefined
} as AuthState

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

        let currentUser = action.payload;
        state.user = currentUser;
        state.logged_in = true

      })
      .addCase(signIn.rejected, (state, action) => {
        state.status = 'failed'
        if (action.payload) {
          state.error = action.payload.error
        } else {
          state.error = action.error.message
        }
      })
      .addCase(signUp.pending, (state, action) => {
        state.status = 'loading'
      })
      .addCase(signUp.fulfilled, (state, action) => {
        state.status = 'succeeded'

        let currentUser = action.payload;
        state.user = currentUser;
        state.logged_in = true

      })
      .addCase(signUp.rejected, (state, action) => {
        state.status = 'failed'
        if (action.payload) {
          state.error = action.payload.error
        } else {
          state.error = action.error.message
        }
      })
      .addCase(logOut.pending, (state, action) => {
        state.status = 'loading'
      })
      .addCase(logOut.fulfilled, (state, action) => {
        state.status = 'succeeded'

        state.logged_in = false;
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

        const response = action.payload;
        state.logged_in = response.logged_in
        state.user = response.user
      })
      .addCase(loggedIn.rejected, (state, action) => {
        state.status = 'failed'
        state.error = action.error.message!
      })
  }
})

export const signIn = createAsyncThunk<CurrentUser, SessionCreationData, { rejectValue: ValidationErrors }>(
  'authentication/signIn',
  async (data, { rejectWithValue }) => {
    try {
      const response = await createNewSession(data);
      return response
    } catch (err) {
      let error = err as AxiosError<ValidationErrors>;
      if (!error.response) {
        throw err;
      }
      return rejectWithValue(error.response.data)
    }
  }
)

export const loggedIn = createAsyncThunk<{ logged_in: boolean, user: CurrentUser }>(
  'auth/loggedIn',
  async () => {
    const response = await checkLoggedIn()
    return response;
  }
)

export const logOut = createAsyncThunk(
  'auth/logOut',
  async () => {
    const response = await closeSession();

  }
)


export const signUp = createAsyncThunk<CurrentUser, UserRegistrationData, { rejectValue: ValidationErrors }>(
  'authentication/signUp',
  async (data, { rejectWithValue }) => {
    try {
      const response = await createNewUser(data);
      return response
    } catch (err) {
      let error = err as AxiosError<ValidationErrors>;
      if (!error.response) {
        throw err;
      }
      return rejectWithValue(error.response.data)
    }
  }
)


export default authSlice.reducer;