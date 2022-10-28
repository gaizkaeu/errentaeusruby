import {  Loading, Text } from '@nextui-org/react'
import {  useGetEstimationByIdQuery } from '../../storage/api'

const EstimationEditForm = (props: {id: string}) => {
  const {isLoading, isError, data} = useGetEstimationByIdQuery(props.id)
  return (
    <div>
      {!data || isLoading || isError ? (<Loading/>) : (
        <div>
          <Text>Estoy editando {data.id}</Text>
          <Text>Home changes: {data.home_changes}</Text>
        </div>
      )}
    </div>
  )
}
export default EstimationEditForm
