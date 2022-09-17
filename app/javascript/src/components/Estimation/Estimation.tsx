import { Button, Card, Grid, Link, Text } from '@nextui-org/react'
import React from 'react'
import { Estimation, EstimationData } from '../../storage/estimationSlice'
import { ArrowIcon } from '../Icons/ArrowIcon'


const SingleEstimation = (props: {
  estimation: Estimation
  req: EstimationData
}) => {
  return (
    <div>
        <div>
          <Text h2>Según tus respuestas</Text>
          <Text h1 color="green">
            el coste es {props.estimation.price} €
          </Text>
        </div>
      <div className="mt-3">
        <Text>Hasta este momento no hemos guardado ningún dato sobre ti. Todo se encuentra en tu <b>navegador.</b></Text>
      </div>
    </div>
  )
}

export default SingleEstimation
