import { at } from "lodash"
import { useField, useFormikContext } from "formik"

export default function FileUploader({ ...props }) {
  const { errorText, ...rest } = props
  const [field, meta, helpers] = useField(props.name)
  const { values, submitForm } = useFormikContext();

  function _renderHelperText() {
    const [touched, error] = at(meta, "touched", "error")
    if (touched && error) {
      return error
    }
  }

  function _renderColor() {
    if (meta.touched) {
      if (meta.error) {
        return "error"
      }
      return "success"
    }
    return "default"
  }

  function formatFiles(files: any, formData = new FormData()) {
    for (let i = 0; i < files.length; i++) {
      formData.append(`files[${i}]`, files[i])
    }
    return formData;
}

  function dropHandler(event: any) {
    event.preventDefault()
    event.stopPropagation()

    const {files} = event.dataTransfer;
    var data = formatFiles(files, field.value)
    helpers.setValue(data)
    submitForm()
  }

  const handleDragOver = (e: any) => {
    e.preventDefault();
    e.stopPropagation();
  };

  function onChange(event: any) {
    helpers.setValue(formatFiles(event.target.files), field.value)
    submitForm()
  }


  return (
    <div className="flex justify-center items-center w-full" onDrop={dropHandler} onDragOver={handleDragOver}>
      <label
        htmlFor="dropzone-file"
        className="flex flex-col justify-center items-center w-full h-64 rounded-lg border-2 cursor-pointer bg-gray-700 border-gray-600 hover:border-gray-500 hover:bg-gray-600"
      >
        <div className="flex flex-col justify-center items-center pt-5 pb-6">
          <svg
            aria-hidden="true"
            className="mb-3 w-10 h-10 text-gray-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
            ></path>
          </svg>
          <p className="mb-2 text-sm dark:text-gray-400">
            <span className="font-semibold">Click to upload</span> or drag and
            drop
          </p>
          <p className="text-xs dark:text-gray-400">
            SVG, PNG, JPG or GIF (MAX. 800x400px)
          </p>
        </div>
        <input
          id="dropzone-file"
          type="file"
          className="hidden"
          multiple={true}
          onChange={onChange}
        />
      </label>
    </div>
  )
}
