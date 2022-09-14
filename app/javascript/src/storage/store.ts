import { combineReducers, configureStore } from '@reduxjs/toolkit'
import estimationSlice from './estimationSlice'


export const store = configureStore({
    reducer: {
        estimations: estimationSlice
    }
})


// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch