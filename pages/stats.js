import Head from "next/head";
import Nav from "../components/Layout/Nav";

export default function Stats() {
  return (
    <div className="text-black">
      <Head>
        <title>Contract Stats</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />
      <div className="flex mx-auto justify-center">
        <p className="text-xl text-gray-600 mx-auto mt-24">Contract Stats</p>
      </div>
      <div className="border m-2 w-3/4 h-auto mx-auto rounded shadow">
        <div className="border m-2 p-2 w-max rounded shadow">Test</div>
      </div>
      <div className="border m-2 w-3/4 h-auto mx-auto rounded shadow">
        <div className="border m-2 p-2 w-max rounded shadow">Test</div>
      </div>
    </div>
  );
}
