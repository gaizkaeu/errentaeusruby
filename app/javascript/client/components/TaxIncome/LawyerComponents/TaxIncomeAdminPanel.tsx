import { Text } from "@nextui-org/react";
import {
  useGetUserByIdQuery,
  useUpdateTaxIncomeMutation,
} from "../../../storage/api";
import { TaxIncome } from "../../../storage/types";
import { Button } from "../../../utils/GlobalStyles";
export const TaxIncomeAdminPanel = (props: { taxIncome: TaxIncome }) => {
  const { data } = useGetUserByIdQuery(props.taxIncome.user);
  const [updateTaxIncome] = useUpdateTaxIncomeMutation();

  return (
    <div>
      <Text h2>Panel de administrador</Text>
      <Text>usuario {data?.first_name}</Text>
      <Button
        onPress={() => {
          updateTaxIncome({
            id: props.taxIncome.id,
            state: "pending_documentation",
          });
        }}
      ></Button>
    </div>
  );
};
