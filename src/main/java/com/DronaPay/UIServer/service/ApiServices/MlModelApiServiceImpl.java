package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.util.RestTemplateUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
public class MlModelApiServiceImpl implements MlModelApiService{

    @Value("${mlflow.server.url}")
    private String mlflow_api_url;

    @Value("${mlflow.api.key}")
    private String mlflow_api_key;

    public ResponseEntity<String> getTrainedModels(List<Integer> tenantIds) throws Exception {
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("x-api-key", mlflow_api_key);

        StringBuilder filterBuilder = new StringBuilder();
        for (int i = 0; i < tenantIds.size(); i++) {
            filterBuilder.append("tags.tenant = '").append(tenantIds.get(i)).append("'");
            if (i < tenantIds.size() - 1) {
                filterBuilder.append(" OR ");
            }
        }

//        String filterEncoded = URLEncoder.encode(filterBuilder.toString(), StandardCharsets.UTF_8);
        String url = mlflow_api_url + "/api/2.0/mlflow/registered-models/search?filter=" + filterBuilder;
        HttpEntity<String> entity = new HttpEntity<>(headers);

        return restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

//    public ResponseEntity<String> getTrainedModels(List<Integer> tenantIds) throws Exception{
//        String sampleResponse = """
//        {
//          "registered_models": [
//            {
//              "name": "my_model",
//              "creation_timestamp": 1746015984367,
//              "last_updated_timestamp": 1746015985197,
//              "latest_versions": [
//                {
//                  "name": "my_model",
//                  "version": "3",
//                  "current_stage": "Production",
//                  "status": "READY",
//                  "run_id": "abc123",
//                  "source": "mlflow-artifacts:/.../artifacts/my_model",
//                  "description": "Production version"
//                },
//                {
//                  "name": "my_model",
//                  "version": "2",
//                  "current_stage": "Staging",
//                  "status": "READY",
//                  "run_id": "def456",
//                  "source": "mlflow-artifacts:/.../artifacts/my_model",
//                  "description": "Staging version"
//                },
//                {
//                  "name": "my_model",
//                  "version": "2.5",
//                  "current_stage": "Archived",
//                  "status": "READY",
//                  "run_id": "ghi789",
//                  "source": "mlflow-artifacts:/.../artifacts/my_model",
//                  "description": "Archived version"
//                },
//                {
//                  "name": "my_model",
//                  "version": "1.5",
//                  "current_stage": "None",
//                  "status": "READY",
//                  "run_id": "xyz321",
//                  "source": "mlflow-artifacts:/.../artifacts/my_model",
//                  "description": "None version"
//                }
//              ],
//              "tags": [
//                {
//                  "key": "tenant",
//                  "value": "6"
//                }
//              ]
//            },
//            {
//              "name": "another_model",
//              "creation_timestamp": 1746015989999,
//              "last_updated_timestamp": 1746015990000,
//              "latest_versions": [
//                {
//                  "name": "another_model",
//                  "version": "1",
//                  "current_stage": "Production",
//                  "status": "READY",
//                  "run_id": "run456",
//                  "source": "mlflow-artifacts:/.../artifacts/another_model",
//                  "description": "Another Production version"
//                }
//              ],
//              "tags": [
//                {
//                  "key": "tenant",
//                  "value": "7"
//                }
//              ]
//            },
//            {
//              "name": "extra_model",
//              "creation_timestamp": 1746016001000,
//              "last_updated_timestamp": 1746016002000,
//              "latest_versions": [
//                {
//                  "name": "extra_model",
//                  "version": "5",
//                  "current_stage": "Staging",
//                  "status": "READY",
//                  "run_id": "run789",
//                  "source": "mlflow-artifacts:/.../artifacts/extra_model",
//                  "description": "Extra model in staging"
//                }
//              ],
//              "tags": [
//                {
//                  "key": "tenant",
//                  "value": "7"
//                }
//              ]
//            },
//            {
//              "name": "archived_model",
//              "creation_timestamp": 1746016003000,
//              "last_updated_timestamp": 1746016004000,
//              "latest_versions": [
//                {
//                  "name": "archived_model",
//                  "version": "1",
//                  "current_stage": "Archived",
//                  "status": "READY",
//                  "run_id": "arch123",
//                  "source": "mlflow-artifacts:/.../artifacts/archived_model",
//                  "description": "Archived model for tenant 20"
//                }
//              ],
//              "tags": [
//                {
//                  "key": "tenant",
//                  "value": "20"
//                }
//              ]
//            },
//            {
//              "name": "prod_model",
//              "creation_timestamp": 1746016005000,
//              "last_updated_timestamp": 1746016006000,
//              "latest_versions": [
//                {
//                  "name": "prod_model",
//                  "version": "10",
//                  "current_stage": "Production",
//                  "status": "READY",
//                  "run_id": "prod999",
//                  "source": "mlflow-artifacts:/.../artifacts/prod_model",
//                  "description": "Production model for tenant 24"
//                }
//              ],
//              "tags": [
//                {
//                  "key": "tenant",
//                  "value": "24"
//                }
//              ]
//            }
//          ]
//        }
//        """;
//
//        return ResponseEntity.ok(sampleResponse);
//    }
}
