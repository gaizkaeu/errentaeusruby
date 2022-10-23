import { Button, Loading, Modal, Text, useModal } from '@nextui-org/react'
import { useEffect } from 'react'
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom'
import { useGetAppointmentByIdQuery, useGetEstimationByIdQuery } from '../../storage/api'

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
