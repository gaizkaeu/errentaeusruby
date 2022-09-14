import { Button, Card, Grid, Link, Text } from '@nextui-org/react'
import React from 'react'
import { IEstimation, IEstimationProps } from '../../storage/estimationSlice'
import { ArrowIcon } from '../Icons/ArrowIcon'

const SingleEstimation = (props: {
  estimation: IEstimation
  req: IEstimationProps
}) => {
  return (
    <React.Fragment>
      <div className="grid items-center grid-cols-1 lg:grid-cols-2 place-items-center">
        <div>
          <Text h2>Según tus respuestas</Text>
          <Text h1 color="green">
            el coste es {props.estimation.price} €
          </Text>
        </div>
        <div>
          <Button
            rounded
            bordered
            flat
            className="px-6 py-4 mt-8"
            color="warning"
            size={'lg'}
            auto
            iconRight={<ArrowIcon />}
          >
            ¿Continuamos?
          </Button>
        </div>
      </div>
      <div className="mt-3">
        <Text>Hasta este momento no hemos guardado ningún dato sobre ti. Todo se encuentra en tu <b>navegador.</b></Text>
      </div>
    </React.Fragment>
  )
}

export default SingleEstimation
