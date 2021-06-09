axios.post("/yourUrl"
                , data,
                {responseType: 'blob'}
            ).then(function (response) {
                    let fileName = response.headers["content-disposition"].split("filename=")[1];
                    if (window.navigator && window.navigator.msSaveOrOpenBlob) { // IE variant
                        window.navigator.msSaveOrOpenBlob(new Blob([response.data], {type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'}),
                            fileName);
                    } else {
                        const url = window.URL.createObjectURL(new Blob([response.data], {type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'}));
                        const link = document.createElement('a');
                        link.href = url;
                        link.setAttribute('download', response.headers["content-disposition"].split("filename=")[1]);
                        document.body.appendChild(link);
                        link.click();
                    }
                }
            );
