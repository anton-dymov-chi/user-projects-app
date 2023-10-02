import BackButton from "@/components/back-button";
import Link from "next/link";

type Props = {
  params: {
    id: number;
  }
}

async function getAssignment(id: number) {
  const response = await fetch(`http://localhost:3000/api/v1/assignments/${id}`, {
    next: {
      revalidate: 60
    }
  });

  if(!response.ok) {
    return response.text().then(message => { throw new Error(message) })
  }

  return response.json();
}

export default async function Assignment({ params: { id } }: Props) {
  const assignment = await getAssignment(id);

  return(
    <>
      <p>Total: {assignment.data.attributes.total}</p>
      <p>Months: {assignment.data.attributes.months}</p>
      <p>RND Percentage: {assignment.data.attributes.rnd_percentage}</p>
      <br />
      <Link href={`/assignments/${id}/edit`}>Edit</Link>
      <br />
      <BackButton />
    </>
  )
}