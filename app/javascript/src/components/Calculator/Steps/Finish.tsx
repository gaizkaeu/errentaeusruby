import { Button, Text } from '@nextui-org/react'
import React, { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { firstStep } from '../../../storage/calculatorSlice'
import { useAppDispatch, useAppSelector } from '../../../storage/hooks'
import CheckAnimated from '../../Icons/CheckAnimated'

const Finish = () => {
  const error = useAppSelector((state) => {
    return state.estimations.error
  })

  const status = useAppSelector((state) => {
    return state.estimations.status
  })

  const dispatch = useAppDispatch();

  const navigation = useNavigate();

  useEffect(() => {
    if (status === 'succeeded') {
        setTimeout(() => {
            navigation('/estimation')
        }, 2000)
    }
  })

  return (
    <React.Fragment>
      {status === 'failed' && error ? (
        <React.Fragment>
          <Text h3>Ha ocurrido un error</Text>
          <Text h4 color="red">
            {error}
          </Text>
          <Button rounded bordered flat color="warning" size={'md'} auto onPress={() => dispatch(firstStep())}>
            Volver a intentarlo
          </Button>
        </React.Fragment>
      ) : (
        <React.Fragment>
            <CheckAnimated/>
        </React.Fragment>
      )}
    </React.Fragment>
  )
}

export default Finish
