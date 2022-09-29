import { Button, Card, Grid, Link, Text } from '@nextui-org/react'
import React from 'react'
import { useNavigate } from 'react-router-dom'
import { firstStep } from '../../storage/calculatorSlice'
import { useAppDispatch, useAppSelector } from '../../storage/hooks'
import { Estimation } from '../../storage/types'
import { ArrowIcon } from '../Icons/ArrowIcon'

const SingleEstimation = (props: {
  estimation: Estimation
}) => {
  const dispatch = useAppDispatch()
  const nav = useNavigate();

  return (
    <div>
      <div>
        <Text h2>Según tus respuestas</Text>
        <Text h1 color="green">
          el coste es {props.estimation.price} €
        </Text>
      </div>
      <div className="mt-3">
        <Text>
          No guardamos <b>ningún dato sobre ti</b>, ni usamos cookies para rastrearte, únicamente lo necesario técnicamente. Nos preocupamos por la confidencialidad.
        </Text>
      </div>
      <Button
        rounded
        bordered
        flat
        className="px-6 py-4 mt-3"
        color="error"
        size={'lg'}
        onPress={() => {
          dispatch(firstStep())
          nav('/calculator')
        }}
        auto
      >
        Quiero revisar mis respuestas.
      </Button>
    </div>
  )
}

export default SingleEstimation
