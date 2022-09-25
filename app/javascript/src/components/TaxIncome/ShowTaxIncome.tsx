import React from 'react'
import { Button, Spacer, Text } from '@nextui-org/react';
import { useAppSelector } from '../../storage/hooks'
import { useNavigate, useParams } from 'react-router-dom'
import 'react-day-picker/dist/style.css';
import { taxSelector } from '../../storage/taxIncomeSlice'
import TaxIncomeCard from './components/TaxIncomeCard';
import EstimationCard from '../Estimation/EstimationCard';
import AssignedLawyer from '../Lawyer/AssignedLawyer';
import { useGetTaxIncomeByIdQuery } from '../../storage/taxIncomeApi';
import { current } from '@reduxjs/toolkit';

const ShowTaxIncome = () => {
  const { id } = useParams()
  const {currentData, isError, isLoading} = useGetTaxIncomeByIdQuery(id!);
  const nav = useNavigate();


  return (
    <React.Fragment>
      <div className="items-center flex flex-wrap gap-10 p-3 self-center place-content-center">
        {!isError && !isLoading ? (
          <React.Fragment>
            <div className="flex-1">
              <TaxIncomeCard taxIncome={currentData!}></TaxIncomeCard>
            </div>
            <div className="w-full lg:w-auto">
{/*               {currentData!.lawyer_id && <AssignedLawyer lawyer={currentData!.lawyer!} /> } */}
              <Spacer/>
              {currentData!.estimation && (<EstimationCard estimation={currentData!.estimation}/>)}
            </div>
          </React.Fragment>
        ) : (
          <Text>Nonnas</Text>
        )}
      </div>

    </React.Fragment>
  )
}

export default ShowTaxIncome
