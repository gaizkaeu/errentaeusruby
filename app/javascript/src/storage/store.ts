import { combineReducers, configureStore } from '@reduxjs/toolkit'
import authSlice from './authSlice'
import calculatorSlice from './calculatorSlice'
import estimationSlice from './estimationSlice'


export const store = configureStore({
    reducer: {
        estimations: estimationSlice,
        authentication: authSlice,
        calculator: calculatorSlice
    }
})


// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch