import BackButton from "@/components/back-button";
import { redirect } from "next/navigation";

type Props = {
  params: {
    id: number;
  }
}

export default function EditAssignment({ params: { id } }: Props) {
  async function updateAssignment(formData: FormData) {
    'use server';

    const data ={
      assignment: {
        months: parseInt(formData.get('assignment[months]')),
        rnd_percentage: parseFloat(formData.get('assignment[rnd_percentage]'))
      }
    };

    const requestOptions = {
      method: 'PUT', 
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    };

    const response = await fetch(`http://localhost:3000/api/v1/assignments/${id}`, requestOptions);

    if(!response.ok) {
      return response.text().then(message => { throw new Error(message) })
    };

    redirect(`/assignments/${id}`);
  }

  return(
    <>
      <h1>Edit Assignment</h1>

      <form action={updateAssignment}>
        <label htmlFor="assignment_month">Months</label><br />
        <input type="number" name="assignment[months]" id="assignment_months" /><br />
        <label htmlFor="assignment_rnd_percentage">RND Percentage</label><br />
        <input type="text" name="assignment[rnd_percentage]" id="assignment_rnd_percentage" />
        <button type="submit">Update</button>
      </form>
      <br />
      <BackButton />
    </>
  )
}
