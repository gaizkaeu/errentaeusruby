import React, { useEffect } from 'react'
import { Card, Grid, Text } from '@nextui-org/react'
import { useAppDispatch, useAppSelector } from '../../storage/hooks'
import { useNavigate } from 'react-router-dom'
import EstimationCard from './components/EstimationCard'
import { NewIcon } from '../Icons/NewIcon'
import { loadTaxIncomes } from '../../storage/taxIncomeSlice'

const MenuTaxIncome = () => {

  return (
    <React.Fragment>
      <Text h3>¡Hola!</Text>

      <Grid.Container gap={2} justify="center">
      <Grid xs={12} md={6}>
        <Card>
          <Card.Body>
            <Text>Default card. (shadow)</Text>
            <NewIcon height={64} width={64}/>
          </Card.Body>
        </Card>
      </Grid>
      <Grid xs={12} md={6}>
        <Card variant="flat">
          <Card.Body>
            <Text>Flat card.</Text>
          </Card.Body>
        </Card>
      </Grid>
      <Grid xs={12}>
        <Card variant="bordered">
          <Card.Body>
            <Text>Bordered card.</Text>
          </Card.Body>
        </Card>
      </Grid>
    </Grid.Container>
    </React.Fragment>
  )
}

export default MenuTaxIncome
