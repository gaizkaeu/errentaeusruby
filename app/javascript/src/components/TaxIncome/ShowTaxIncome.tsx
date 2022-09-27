import React from 'react'
import { Spacer, Text } from '@nextui-org/react';
import { useNavigate, useParams } from 'react-router-dom'
import 'react-day-picker/dist/style.css';
import TaxIncomeCard from './components/TaxIncomeCard';
import EstimationCard from '../Estimation/EstimationCard';
import AssignedLawyer from '../Lawyer/AssignedLawyer';
import { useGetTaxIncomeByIdQuery } from '../../storage/api';
import Estimation from '../Estimation/Estimation';
import NoEstimationCard from '../Estimation/NoEstimationCard';

const ShowTaxIncome = () => {
  const { id } = useParams()
  const {currentData, isError, isLoading} = useGetTaxIncomeByIdQuery(id!);

  return (
    <React.Fragment>
      <div className="items-center flex flex-wrap gap-10 p-3 self-center place-content-center">
        {!isError && !isLoading && currentData? (
          <React.Fragment>
            <div className="flex-1">
              <TaxIncomeCard taxIncome={currentData!}></TaxIncomeCard>
            </div>
            <div className="w-full lg:w-auto">
              {currentData.lawyer && <AssignedLawyer lawyerId={currentData.lawyer} /> }
              <Spacer/>
              {currentData.estimation ? <Estimation estimationId={currentData.estimation}/> : <NoEstimationCard/> }
            </div>
          </React.Fragment>
        ) : (
          <Text>Cargando... o no tienes permisos</Text>
        )}
      </div>

    </React.Fragment>
  )
}

export default ShowTaxIncome
