import { Text } from '@nextui-org/react'
import { Estimation } from '../../storage/types'
import EstimationCard from './Card/EstimationCard'

const SingleEstimation = (props: {
  estimation: Estimation
}) => {

  return (
    <div>
      <div>
        <Text h2>Según tus respuestas</Text>
        <EstimationCard estimation={props.estimation} deletable/>
      </div>
      <div className="mt-3">
        <Text>
          No guardamos <b>ningún dato sobre ti</b>, ni usamos cookies para rastrearte, únicamente lo necesario técnicamente. Nos preocupamos por la confidencialidad.
        </Text>
      </div>
    </div>
  )
}

export default SingleEstimation
