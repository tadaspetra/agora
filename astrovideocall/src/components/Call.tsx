import AgoraUIKit from 'agora-react-uikit';
import { useState } from 'react';

interface AppInfo {
  channelName: string;   
  uid: string;
  appId: string;
}

const Call = (props:AppInfo) => {
  const [videoCall, setVideoCall] = useState(true);
  const rtcProps = {
    appId: props.appId, // enter your agora appid here
    channel: props.channelName, // your agora channel
    token: null// use null or skip if using app in testing mode
  };
  const callbacks = {
    EndCall: () => setVideoCall(false),
  };

  
  return videoCall ? (
    <div style={{display: 'flex', width: '100vw', height: '100vh'}}>
   
      <AgoraUIKit rtcProps={rtcProps} callbacks={callbacks} /> 
    </div>
  ) : (
    <div className='ml-2 flex flex-col'>
      <div className='pt-10'></div>
      <button className="px-5 py-3 mt-5 text-base font-medium text-center text-white bg-gray-400 rounded-lg hover:bg-gray-500 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900 w-40" onClick={() => setVideoCall(true)}>Rejoin Call</button>
      <a className=" px-5 py-3 mt-5 text-base font-medium text-center text-white bg-blue-400 rounded-lg hover:bg-blue-500 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900 w-40" href='/'>Back</a>
    </div>
  );
};

export default Call;