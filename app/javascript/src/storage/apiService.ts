import axios from "axios";
import { CurrentUser, SessionCreationData, UserRegistrationData } from "./authSlice";
import { Estimation, EstimationData } from "./estimationSlice";

const API_BASE = "/"

const checkLoggedIn = async () => {
    const response = await axios.get<{user: CurrentUser, logged_in: boolean}>(API_BASE + 'api/v1/logged_in')
    return response.data;
}

const createNewUser = async (data: UserRegistrationData) => {
    const response = await axios.post<CurrentUser>(API_BASE + 'api/v1/users', {api_v1_user: data})
    return response.data;
}

const createNewSession = async (data: SessionCreationData) => {
    const response = await axios.post<CurrentUser>(API_BASE + 'api/v1/users/sign_in', {api_v1_user: data})
    return response.data;
}

const createNewEstimation = async (data: EstimationData) => {
    const response = await axios.post<Estimation>(API_BASE + 'api/v1/estimations/estimate', data)
    return response.data;
}

export {createNewEstimation, checkLoggedIn, createNewUser, createNewSession};