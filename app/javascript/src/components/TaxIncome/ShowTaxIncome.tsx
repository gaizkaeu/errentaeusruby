import React from 'react'
import { Button, Text } from '@nextui-org/react';
import { useAppSelector } from '../../storage/hooks'
import { useNavigate, useParams } from 'react-router-dom'
import 'react-day-picker/dist/style.css';
import { taxSelector } from '../../storage/taxIncomeSlice'

const ShowTaxIncome = () => {
  const {id} = useParams()
  const taxIncome = useAppSelector((state) => taxSelector.selectById(state.taxIncomes, id!))
  const nav = useNavigate();

  return (
    <React.Fragment>
      <Button onPress={() => nav("/mytaxincome")}>Atrás</Button>
      <Text h3>Estado: {taxIncome?.state}</Text>
      <Text h3>Precio {taxIncome?.price}</Text>
      <Text h3>Creado el {taxIncome?.created_at}</Text>

    </React.Fragment>
  )
}

export default ShowTaxIncome
