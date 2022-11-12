import { Text } from "@nextui-org/react";
import { at } from "lodash";
import { useField } from "formik";
import { DayOfWeek, DayPicker } from "react-day-picker";
import es from "date-fns/locale/es";
import { addDays } from "date-fns";

export default function DatePickerField(props: { name: string }) {
  const [field, meta, helpers] = useField(props.name);
  const dayOfWeekMatcher: DayOfWeek = {
    dayOfWeek: [0, 6],
  };

  function _renderHelperText() {
    const [touched, error] = at(meta, "touched", "error");
    if (touched && error) {
      return <Text>{error}</Text>;
    }
  }

  return (
    <DayPicker
      mode="single"
      selected={field.value}
      locale={es}
      disabled={[dayOfWeekMatcher, { before: addDays(new Date(), 1) }]}
      footer={<Text color="error">{_renderHelperText()}</Text>}
      onSelect={(day: any) => {
        helpers.setValue(day);
      }}
      showOutsideDays
    />
  );
}
