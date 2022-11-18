import { createSlice } from "@reduxjs/toolkit";
import { api } from "./api";
import { AuthState } from "./types";

// Define the initial state using that type
const initialState = {
  status: "succeeded",
  error: "",
  logged_in: false,
  user: undefined,
} as AuthState;

const authSlice = createSlice({
  name: "authentication",
  initialState: initialState,
  reducers: {},
  extraReducers(builder) {
    builder
      .addMatcher(
        api.endpoints.loginAccount.matchFulfilled,
        (state, { payload }) => {
          state.status = "succeeded";
          state.user = payload;
          state.logged_in = true;
        }
      )
      .addMatcher(api.endpoints.logOut.matchFulfilled, (state) => {
        state.status = "succeeded";
        state.user = undefined;
        state.logged_in = false;
      })
      .addMatcher(
        api.endpoints.createNewAccount.matchFulfilled,
        (state, { payload }) => {
          state.status = "succeeded";
          state.user = payload;
          state.logged_in = true;
        }
      )
      .addMatcher(
        api.endpoints.getCurrentAccount.matchFulfilled,
        (state, { payload }) => {
          state.status = "succeeded";
          state.user = payload;
          state.logged_in = payload.id ? true : false;
        }
      );
  },
});

export default authSlice.reducer;
