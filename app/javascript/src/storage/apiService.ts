import axios from "axios";
import { IUser, UserRegistrationData, SessionCreationData, EstimationData, Estimation, TaxIncomeData, TaxIncome } from "./types";
const API_BASE = "/"

const checkLoggedIn = async () => {
    const response = await axios.get<{user: IUser, logged_in: boolean}>(API_BASE + 'api/v1/logged_in')
    return response.data;
}

const createNewUser = async (data: UserRegistrationData) => {
    const response = await axios.post<IUser>(API_BASE + 'api/v1/users', {api_v1_user: data})
    return response.data;
}

const createNewSession = async (data: SessionCreationData) => {
    const response = await axios.post<IUser>(API_BASE + 'api/v1/users/sign_in', {api_v1_user: data})
    return response.data;
}

const closeSession = async () => {
   const response = await axios.delete(API_BASE + '/api/v1/users/sign_out') 
   return response.status;
}

const createNewEstimation = async (data: EstimationData) => {
    const response = await axios.post<Estimation>(API_BASE + 'api/v1/estimations/estimate', data)
    return response.data;
}

const myEstimation = async () => {
    const response = await axios.get<Estimation>(API_BASE + 'api/v1/estimations/my_estimation')
    return response.data;
}

export {createNewEstimation, checkLoggedIn, createNewUser, createNewSession, closeSession, myEstimation};