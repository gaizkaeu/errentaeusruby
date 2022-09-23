import React from 'react'
import { Button, Text } from '@nextui-org/react';
import { useAppSelector } from '../../storage/hooks'
import { useNavigate, useParams } from 'react-router-dom'
import 'react-day-picker/dist/style.css';
import { taxSelector } from '../../storage/taxIncomeSlice'
import TaxIncomeCard from './components/TaxIncomeCard';
import EstimationCard from './components/EstimationCard';

const ShowTaxIncome = () => {
  const { id } = useParams()
  const taxIncome = useAppSelector((state) => taxSelector.selectById(state.taxIncomes, id!))
  const nav = useNavigate();


  return (
    <React.Fragment>
      <Button onPress={() => nav("/mytaxincome")}>Atrás</Button>
      <div className="grid items-center grid-cols-1 lg:grid-cols-2 gap-10 p-3 self-center">
        {taxIncome ? (
          <React.Fragment>
            <TaxIncomeCard taxIncome={taxIncome}></TaxIncomeCard>
            {taxIncome.estimation && <EstimationCard estimation={taxIncome.estimation}></EstimationCard>}
          </React.Fragment>
        ) : (
          <Text>Nonnas</Text>
        )}
      </div>

    </React.Fragment>
  )
}

export default ShowTaxIncome
