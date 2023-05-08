
exports.handler = async event => {
  console.log('Lambda query blacklist');
  console.log('Step:', event['step']);
  console.log('Data:', event['data']);
  return {message:'Lambda query blacklist finished', data: event['data']}
};
